import {
  createTunnel,
  ForwardOptions,
  ServerOptions,
  TunnelOptions,
} from 'tunnel-ssh';
import * as dotenv from 'dotenv';

dotenv.config();

interface DBConfig {
  host: string;
  user: string;
  password: string;
  database: string;
}

interface SSHOptions {
  host: string;
  port: number;
  username: string;
  password: string;
}

const dbConfig: DBConfig = {
  host: process.env.DB_HOST!,
  user: process.env.DB_USERNAME!,
  password: process.env.DB_PASSWORD!,
  database: process.env.DB_NAME!,
};

const sshOptions: SSHOptions = {
  host: process.env.SSH_HOST!,
  port: 1225,
  username: process.env.SSH_USER!,
  password: process.env.SSH_PASSWORD!,
};

export function mySimpleTunnel(
  sshOptions: SSHOptions,
  port: number,
  autoClose = true,
) {
  const forwardOptions: ForwardOptions = {
    srcAddr: '127.0.0.1',
    srcPort: port,
    dstAddr: '127.0.0.1',
    dstPort: port,
  };

  const tunnelOptions: TunnelOptions = {
    autoClose: autoClose,
  };

  const serverOptions: ServerOptions = {
    port: port,
  };

  return createTunnel(tunnelOptions, serverOptions, sshOptions, forwardOptions);
}

export async function establishSSHconnection() {
  await mySimpleTunnel(sshOptions, 3306);
}
