import { Controller, Get, Inject, Query } from "@nestjs/common";
import { ApiTags, ApiOperation } from "@nestjs/swagger";
import { AppService } from "./app.service";

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    @Inject("DB") private readonly db: any
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get("health")
  getHealth() {
    return {
      status: "ok",
      timestamp: new Date().toISOString(),
    };
  }

  @Get("tax/structures")
  @ApiTags("tax")
  @ApiOperation({ summary: "Get tax structures" })
  async getTaxStructures() {
    // TODO: Implement actual tax structures from database
    // For now, returning empty array - this should be implemented with actual tax_structure table
    return [];
  }

  @Get("shipping/profiles")
  @ApiTags("shipping")
  @ApiOperation({ summary: "Get shipping profiles" })
  async getShippingProfiles(@Query() query: any) {
    // TODO: Implement actual shipping profiles from database
    // For now, returning empty array - this should be implemented with actual shipping_profile table
    // The frontend expects: { id: number, identifier: string, name: string, isDefault: boolean }[]
    return [];
  }
}

