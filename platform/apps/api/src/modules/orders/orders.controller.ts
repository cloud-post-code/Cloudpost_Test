import { Controller, Get, Post, Put, Param, Query, Body, Inject } from "@nestjs/common";
import { ApiTags, ApiOperation } from "@nestjs/swagger";
import { OrdersService } from "./orders.service";

@ApiTags("orders")
@Controller("orders")
export class OrdersController {
  constructor(
    @Inject("DB") private readonly db: any,
    private readonly ordersService: OrdersService
  ) {}

  @Get()
  @ApiOperation({ summary: "Get orders list" })
  async getOrders(@Query() query: any) {
    return this.ordersService.getOrders(query);
  }

  @Get(":id")
  @ApiOperation({ summary: "Get order by ID" })
  async getOrder(@Param("id") id: string) {
    return this.ordersService.getOrder(parseInt(id));
  }

  @Put(":id/status")
  @ApiOperation({ summary: "Update order status" })
  async updateOrderStatus(@Param("id") id: string, @Body() data: any) {
    return this.ordersService.updateOrderStatus(parseInt(id), data);
  }
}

