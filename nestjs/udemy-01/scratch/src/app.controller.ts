import { Controller, Get } from "@nestjs/common";

@Controller("/app")
export class AppController {
  @Get("/sample")
  getRootRoute() {
    return "hi there!";
  }
}
