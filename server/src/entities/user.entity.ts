import {Column, Entity, PrimaryGeneratedColumn} from "typeorm";

@Entity()
class User {
    @PrimaryGeneratedColumn()
    userId: number;

    @Column({ unique: true })
    username: string;

    @Column()
    password: string;

    @Column()
    profileImageURL: string;

    @Column()
    temperature: number;

    @Column()
    createAt: Date;

    @Column()
    recentActive: Date;
}