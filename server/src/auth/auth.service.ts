import { Injectable } from '@nestjs/common';
import {AuthCredentialDto} from "./dto/auth.credential.dto";
import request from "request";

@Injectable()
export class AuthService {

    signIn (authCredentialDto: AuthCredentialDto) {

    }

    async getId(token: string) {
        const header = "Bearer " + token;
        const api_url = 'https://openapi.naver.com/v1/nid/me';
        const options = {
            url: api_url,
            headers: {'Authorization': header}
        };
        const response = await fetch(api_url, {
            method: 'GET',
            headers: {
                'Authorization': header,
            },
        });

        return await response.json();
    }
}
