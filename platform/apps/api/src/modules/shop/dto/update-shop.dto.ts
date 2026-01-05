import { IsString, IsOptional, IsBoolean, IsNumber, IsArray, ValidateNested, IsObject } from "class-validator";
import { Type } from "class-transformer";
import { ApiProperty, ApiPropertyOptional } from "@nestjs/swagger";

export class PickupLocationDto {
  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  id?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  countryId?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  stateId?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  city?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  address1?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  address2?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  postalCode?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  lat?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  lng?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}

export class ReturnAddressDto {
  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  countryId?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  stateId?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  city?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  address1?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  address2?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  postalCode?: string;
}

export class UpdateShopDto {
  // General Info
  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  name?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  url?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  phoneDcode?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  phone?: string;

  // Address
  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  countryId?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  stateId?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  city?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  address1?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  address2?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  postalCode?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  returnAddressSame?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @ValidateNested()
  @Type(() => ReturnAddressDto)
  returnAddress?: ReturnAddressDto;

  // Settings
  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  vacationStatus?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  returnEligibilityDays?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  cancellationEligibilityDays?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  fulfillmentMethod?: number; // 1 = Shipping, 2 = Pickup

  // Shop Esthetic
  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  logo?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  banner?: string;

  // Shop Info (Language-specific)
  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  langId?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  sellerInformation?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  paymentPolicy?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  shippingPolicy?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  refundPolicy?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  additionalInformation?: string;

  // Pickup Locations
  @ApiPropertyOptional({ type: [PickupLocationDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => PickupLocationDto)
  pickupLocations?: PickupLocationDto[];
}

