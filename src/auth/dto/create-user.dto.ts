import { ApiProperty } from '@nestjs/swagger';
import {
  IsEmail,
  IsString,
  Matches,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateUserDto {
  @ApiProperty({
    example: 'Fulanito',
    description: 'User name',
  })
  @IsString()
  @MinLength(2)
  first_name: string;

  @ApiProperty({
    example: 'Perez',
    description: 'User last_name',
  })
  @IsString()
  @MinLength(2)
  last_Name: string;

  @ApiProperty({
    example: 'Fulanito@mail.com',
    description: 'User email',
    uniqueItems: true,
  })
  @IsString()
  @IsEmail()
  email: string;

  @ApiProperty({
    example: 'any_password@123',
    description: 'User password',
  })
  @IsString()
  @MinLength(8)
  @MaxLength(50)
  @Matches(
    /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\|\-]).{8,}$/,
    {
      message:
        'The password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character',
    },
  )
  password: string;
}
