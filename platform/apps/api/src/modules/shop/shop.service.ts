import { Injectable, Inject, NotFoundException } from "@nestjs/common";
import { eq, and, inArray } from "drizzle-orm";
import { shops, shopsLang, shopPickupLocations } from "@cloudpost/database";
import { UpdateShopDto } from "./dto/update-shop.dto";

@Injectable()
export class ShopService {
  constructor(@Inject("DB") private readonly db: any) {}

  async getShop(userId: number, langId: number = 1) {
    // Get shop by user ID
    const [shop] = await this.db
      .select()
      .from(shops)
      .where(eq(shops.userId, userId))
      .limit(1);

    if (!shop) {
      throw new NotFoundException("Shop not found");
    }

    // Get language-specific data
    const [shopLang] = await this.db
      .select()
      .from(shopsLang)
      .where(and(eq(shopsLang.shopId, shop.id), eq(shopsLang.langId, langId)))
      .limit(1);

    // Get pickup locations
    const pickupLocations = await this.db
      .select()
      .from(shopPickupLocations)
      .where(eq(shopPickupLocations.shopId, shop.id));

    // Combine and structure the response
    return {
      id: shop.id,
      userId: shop.userId,
      identifier: shop.identifier,
      // General Info
      name: shopLang?.name || "",
      url: shop.url,
      phoneDcode: shop.phoneDcode,
      phone: shop.phone?.toString(),
      // Address
      countryId: shop.countryId,
      stateId: shop.stateId,
      city: shop.city,
      address1: shop.address1,
      address2: shop.address2,
      postalCode: shop.postalCode,
      returnAddressSame: shop.returnAddressSame,
      // Settings
      vacationStatus: shop.vacationStatus,
      returnEligibilityDays: shop.returnEligibilityDays,
      cancellationEligibilityDays: shop.cancellationEligibilityDays,
      fulfillmentMethod: shop.fulfillmentMethod,
      // Shop Esthetic
      logo: shop.logo,
      banner: shop.banner,
      // Shop Info
      description: shopLang?.description || "",
      sellerInformation: shopLang?.sellerInformation || "",
      paymentPolicy: shopLang?.paymentPolicy || "",
      shippingPolicy: shopLang?.shippingPolicy || "",
      refundPolicy: shopLang?.refundPolicy || "",
      additionalInformation: shopLang?.additionalInformation || "",
      // Pickup Locations
      pickupLocations: pickupLocations.map((loc) => ({
        id: loc.id,
        countryId: loc.countryId,
        stateId: loc.stateId,
        city: loc.city,
        address1: loc.address1,
        address2: loc.address2,
        postalCode: loc.postalCode,
        lat: loc.lat,
        lng: loc.lng,
        isActive: loc.isActive,
      })),
      active: shop.active,
      featured: shop.featured,
      createdAt: shop.createdAt,
      updatedAt: shop.updatedAt,
    };
  }

  async updateShop(userId: number, data: UpdateShopDto, langId: number = 1) {
    // Get existing shop
    const [shop] = await this.db
      .select()
      .from(shops)
      .where(eq(shops.userId, userId))
      .limit(1);

    if (!shop) {
      throw new NotFoundException("Shop not found");
    }

    // Prepare shop update data
    const shopUpdateData: any = {
      updatedAt: new Date(),
    };

    if (data.url !== undefined) shopUpdateData.url = data.url;
    if (data.phoneDcode !== undefined) shopUpdateData.phoneDcode = data.phoneDcode;
    if (data.phone !== undefined) shopUpdateData.phone = data.phone ? BigInt(data.phone) : null;
    if (data.countryId !== undefined) shopUpdateData.countryId = data.countryId;
    if (data.stateId !== undefined) shopUpdateData.stateId = data.stateId;
    if (data.city !== undefined) shopUpdateData.city = data.city;
    if (data.address1 !== undefined) shopUpdateData.address1 = data.address1;
    if (data.address2 !== undefined) shopUpdateData.address2 = data.address2;
    if (data.postalCode !== undefined) shopUpdateData.postalCode = data.postalCode;
    if (data.returnAddressSame !== undefined) shopUpdateData.returnAddressSame = data.returnAddressSame;
    if (data.vacationStatus !== undefined) shopUpdateData.vacationStatus = data.vacationStatus;
    if (data.returnEligibilityDays !== undefined) shopUpdateData.returnEligibilityDays = data.returnEligibilityDays;
    if (data.cancellationEligibilityDays !== undefined) shopUpdateData.cancellationEligibilityDays = data.cancellationEligibilityDays;
    if (data.fulfillmentMethod !== undefined) shopUpdateData.fulfillmentMethod = data.fulfillmentMethod;
    if (data.logo !== undefined) shopUpdateData.logo = data.logo;
    if (data.banner !== undefined) shopUpdateData.banner = data.banner;

    // Update shop
    await this.db.update(shops).set(shopUpdateData).where(eq(shops.id, shop.id));

    // Update or create language-specific data
    const shopLangUpdateData: any = {};
    if (data.name !== undefined) shopLangUpdateData.name = data.name;
    if (data.description !== undefined) shopLangUpdateData.description = data.description;
    if (data.sellerInformation !== undefined) shopLangUpdateData.sellerInformation = data.sellerInformation;
    if (data.paymentPolicy !== undefined) shopLangUpdateData.paymentPolicy = data.paymentPolicy;
    if (data.shippingPolicy !== undefined) shopLangUpdateData.shippingPolicy = data.shippingPolicy;
    if (data.refundPolicy !== undefined) shopLangUpdateData.refundPolicy = data.refundPolicy;
    if (data.additionalInformation !== undefined) shopLangUpdateData.additionalInformation = data.additionalInformation;

    const [existingLang] = await this.db
      .select()
      .from(shopsLang)
      .where(and(eq(shopsLang.shopId, shop.id), eq(shopsLang.langId, langId)))
      .limit(1);

    if (existingLang && Object.keys(shopLangUpdateData).length > 0) {
      await this.db
        .update(shopsLang)
        .set(shopLangUpdateData)
        .where(and(eq(shopsLang.shopId, shop.id), eq(shopsLang.langId, langId)));
    } else if (Object.keys(shopLangUpdateData).length > 0) {
      await this.db.insert(shopsLang).values({
        shopId: shop.id,
        langId: langId,
        name: data.name || "",
        ...shopLangUpdateData,
      });
    }

    // Handle pickup locations
    if (data.pickupLocations !== undefined) {
      // Get existing pickup locations
      const existingLocations = await this.db
        .select()
        .from(shopPickupLocations)
        .where(eq(shopPickupLocations.shopId, shop.id));

      const existingIds = existingLocations.map((loc) => loc.id);
      const incomingIds = data.pickupLocations
        .filter((loc) => loc.id !== undefined)
        .map((loc) => loc.id as number);

      // Delete locations that are no longer in the list
      const idsToDelete = existingIds.filter((id) => !incomingIds.includes(id));
      if (idsToDelete.length > 0) {
        await this.db
          .delete(shopPickupLocations)
          .where(inArray(shopPickupLocations.id, idsToDelete));
      }

      // Update or create locations
      for (const location of data.pickupLocations) {
        if (location.id && existingIds.includes(location.id)) {
          // Update existing
          const updateData: any = { updatedAt: new Date() };
          if (location.countryId !== undefined) updateData.countryId = location.countryId;
          if (location.stateId !== undefined) updateData.stateId = location.stateId;
          if (location.city !== undefined) updateData.city = location.city;
          if (location.address1 !== undefined) updateData.address1 = location.address1;
          if (location.address2 !== undefined) updateData.address2 = location.address2;
          if (location.postalCode !== undefined) updateData.postalCode = location.postalCode;
          if (location.lat !== undefined) updateData.lat = location.lat;
          if (location.lng !== undefined) updateData.lng = location.lng;
          if (location.isActive !== undefined) updateData.isActive = location.isActive;

          await this.db
            .update(shopPickupLocations)
            .set(updateData)
            .where(eq(shopPickupLocations.id, location.id));
        } else {
          // Create new
          await this.db.insert(shopPickupLocations).values({
            shopId: shop.id,
            countryId: location.countryId,
            stateId: location.stateId,
            city: location.city,
            address1: location.address1,
            address2: location.address2,
            postalCode: location.postalCode,
            lat: location.lat,
            lng: location.lng,
            isActive: location.isActive !== undefined ? location.isActive : true,
          });
        }
      }
    }

    // Return updated shop
    return this.getShop(userId, langId);
  }
}

