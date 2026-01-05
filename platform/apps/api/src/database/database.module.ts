import { Module, Global } from "@nestjs/common";
import { db } from "@cloudpost/database";

@Global()
@Module({
  providers: [
    {
      provide: "DB",
      useValue: db,
    },
  ],
  exports: ["DB"],
})
export class DatabaseModule {}

