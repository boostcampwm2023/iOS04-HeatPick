import {Body, Controller, Post} from '@nestjs/common';
import {AuthService} from "./auth.service";
import {AuthCredentialDto} from "./dto/auth.credential.dto";

@Controller('auth')
@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @Post('signup')
    signUp(@Body() authCredentialDto: AuthCredentialDto): Promise<void> {
        return this.authService.signUp(authCredentialDto);
    }

    @Post('signin')
    signIn(
        @Body() authCredentialDto: AuthCredentialDto,
    ): Promise<{ accessToken: string }> {
        return this.authService.signIn(authCredentialDto);
    }
}
