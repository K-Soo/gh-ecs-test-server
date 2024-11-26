import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'ECS Fargate with NestJS!!!!!!';
  }
}
