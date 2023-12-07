import { DataSource } from 'typeorm';
import { establishSSHconnection } from './dbConnection';
import * as dotenv from 'dotenv';
import { query } from 'express';
import { addTransactionalDataSource } from 'typeorm-transactional';

dotenv.config();

export const databaseProviders = [
  {
    provide: 'DATA_SOURCE',
    useFactory: async () => {
      await establishSSHconnection();
      const dataSource = new DataSource({
        type: 'mysql',
        host: 'localhost',
        port: 3306,
        username: process.env.DB_USERNAME,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
        entities: [__dirname + '/../**/*.entity{.ts,.js}'],
        synchronize: true,
        extra: {
          connectionLimit: 10,
          waitForConnections: true,
          connectTimeout: 20000,
          idleTimeout: 60000,
        },
        cache: true,
      });

      return addTransactionalDataSource(await dataSource.initialize());
    },
  },
];
