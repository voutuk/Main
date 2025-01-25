using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class Add_tbl_to_tables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AdminMessage_AspNetUsers_UserId",
                table: "AdminMessage");

            migrationBuilder.DropForeignKey(
                name: "FK_Advert_AspNetUsers_UserId",
                table: "Advert");

            migrationBuilder.DropForeignKey(
                name: "FK_Advert_Category_CategoryId",
                table: "Advert");

            migrationBuilder.DropForeignKey(
                name: "FK_Advert_Settlement_SettlementRef",
                table: "Advert");

            migrationBuilder.DropForeignKey(
                name: "FK_AdvertFilterValue_Advert_AdvertsId",
                table: "AdvertFilterValue");

            migrationBuilder.DropForeignKey(
                name: "FK_AdvertFilterValue_FilterValue_FilterValuesId",
                table: "AdvertFilterValue");

            migrationBuilder.DropForeignKey(
                name: "FK_AdvertImage_Advert_AdvertId",
                table: "AdvertImage");

            migrationBuilder.DropForeignKey(
                name: "FK_AspNetUsers_Settlement_SettlementRef",
                table: "AspNetUsers");

            migrationBuilder.DropForeignKey(
                name: "FK_Category_Category_ParentId",
                table: "Category");

            migrationBuilder.DropForeignKey(
                name: "FK_CategoryFilter_Category_CategoriesId",
                table: "CategoryFilter");

            migrationBuilder.DropForeignKey(
                name: "FK_CategoryFilter_Filter_FiltersId",
                table: "CategoryFilter");

            migrationBuilder.DropForeignKey(
                name: "FK_Chat_Advert_AdvertId",
                table: "Chat");

            migrationBuilder.DropForeignKey(
                name: "FK_Chat_AspNetUsers_BuyerId",
                table: "Chat");

            migrationBuilder.DropForeignKey(
                name: "FK_Chat_AspNetUsers_SellerId",
                table: "Chat");

            migrationBuilder.DropForeignKey(
                name: "FK_ChatMessage_AspNetUsers_SenderId",
                table: "ChatMessage");

            migrationBuilder.DropForeignKey(
                name: "FK_ChatMessage_Chat_ChatId",
                table: "ChatMessage");

            migrationBuilder.DropForeignKey(
                name: "FK_FilterValue_Filter_FilterId",
                table: "FilterValue");

            migrationBuilder.DropForeignKey(
                name: "FK_RefreshToken_AspNetUsers_OlxUserId",
                table: "RefreshToken");

            migrationBuilder.DropForeignKey(
                name: "FK_Region_Area_AreaRef",
                table: "Region");

            migrationBuilder.DropForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement");

            migrationBuilder.DropForeignKey(
                name: "FK_UserFavorites_Advert_FavoriteAdvertsId",
                table: "UserFavorites");

            migrationBuilder.DropForeignKey(
                name: "FK_UserFavorites_AspNetUsers_FavoritedByUsersId",
                table: "UserFavorites");

            migrationBuilder.DropForeignKey(
                name: "FK_Warehous_Settlement_SettlementRef",
                table: "Warehous");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Warehous",
                table: "Warehous");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserFavorites",
                table: "UserFavorites");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Settlement",
                table: "Settlement");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Region",
                table: "Region");

            migrationBuilder.DropPrimaryKey(
                name: "PK_RefreshToken",
                table: "RefreshToken");

            migrationBuilder.DropPrimaryKey(
                name: "PK_FilterValue",
                table: "FilterValue");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Filter",
                table: "Filter");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ChatMessage",
                table: "ChatMessage");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Chat",
                table: "Chat");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CategoryFilter",
                table: "CategoryFilter");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Category",
                table: "Category");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Area",
                table: "Area");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AdvertImage",
                table: "AdvertImage");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AdvertFilterValue",
                table: "AdvertFilterValue");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Advert",
                table: "Advert");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AdminMessage",
                table: "AdminMessage");

            migrationBuilder.RenameTable(
                name: "Warehous",
                newName: "tbl_Warehouses");

            migrationBuilder.RenameTable(
                name: "UserFavorites",
                newName: "tbl_UserFavorites");

            migrationBuilder.RenameTable(
                name: "Settlement",
                newName: "tbl_Settlements");

            migrationBuilder.RenameTable(
                name: "Region",
                newName: "tbl_Regions");

            migrationBuilder.RenameTable(
                name: "RefreshToken",
                newName: "tbl_RefreshTokens");

            migrationBuilder.RenameTable(
                name: "FilterValue",
                newName: "tbl_FilterValues");

            migrationBuilder.RenameTable(
                name: "Filter",
                newName: "tbl_Filters");

            migrationBuilder.RenameTable(
                name: "ChatMessage",
                newName: "tbl_ChatMessages");

            migrationBuilder.RenameTable(
                name: "Chat",
                newName: "tbl_Chats");

            migrationBuilder.RenameTable(
                name: "CategoryFilter",
                newName: "tbl_CategoryFilters");

            migrationBuilder.RenameTable(
                name: "Category",
                newName: "tbl_Categories");

            migrationBuilder.RenameTable(
                name: "Area",
                newName: "tbl_Areas");

            migrationBuilder.RenameTable(
                name: "AdvertImage",
                newName: "tbl_AdvertImages");

            migrationBuilder.RenameTable(
                name: "AdvertFilterValue",
                newName: "tbl_AdvertFilterValues");

            migrationBuilder.RenameTable(
                name: "Advert",
                newName: "tbl_Adverts");

            migrationBuilder.RenameTable(
                name: "AdminMessage",
                newName: "tbl_AdminMessages");

            migrationBuilder.RenameIndex(
                name: "IX_Warehous_SettlementRef",
                table: "tbl_Warehouses",
                newName: "IX_tbl_Warehouses_SettlementRef");

            migrationBuilder.RenameIndex(
                name: "IX_UserFavorites_FavoritedByUsersId",
                table: "tbl_UserFavorites",
                newName: "IX_tbl_UserFavorites_FavoritedByUsersId");

            migrationBuilder.RenameIndex(
                name: "IX_Settlement_Region",
                table: "tbl_Settlements",
                newName: "IX_tbl_Settlements_Region");

            migrationBuilder.RenameIndex(
                name: "IX_Region_AreaRef",
                table: "tbl_Regions",
                newName: "IX_tbl_Regions_AreaRef");

            migrationBuilder.RenameIndex(
                name: "IX_RefreshToken_OlxUserId",
                table: "tbl_RefreshTokens",
                newName: "IX_tbl_RefreshTokens_OlxUserId");

            migrationBuilder.RenameIndex(
                name: "IX_FilterValue_FilterId",
                table: "tbl_FilterValues",
                newName: "IX_tbl_FilterValues_FilterId");

            migrationBuilder.RenameIndex(
                name: "IX_ChatMessage_SenderId",
                table: "tbl_ChatMessages",
                newName: "IX_tbl_ChatMessages_SenderId");

            migrationBuilder.RenameIndex(
                name: "IX_ChatMessage_ChatId",
                table: "tbl_ChatMessages",
                newName: "IX_tbl_ChatMessages_ChatId");

            migrationBuilder.RenameIndex(
                name: "IX_Chat_SellerId",
                table: "tbl_Chats",
                newName: "IX_tbl_Chats_SellerId");

            migrationBuilder.RenameIndex(
                name: "IX_Chat_BuyerId",
                table: "tbl_Chats",
                newName: "IX_tbl_Chats_BuyerId");

            migrationBuilder.RenameIndex(
                name: "IX_Chat_AdvertId",
                table: "tbl_Chats",
                newName: "IX_tbl_Chats_AdvertId");

            migrationBuilder.RenameIndex(
                name: "IX_CategoryFilter_FiltersId",
                table: "tbl_CategoryFilters",
                newName: "IX_tbl_CategoryFilters_FiltersId");

            migrationBuilder.RenameIndex(
                name: "IX_Category_ParentId",
                table: "tbl_Categories",
                newName: "IX_tbl_Categories_ParentId");

            migrationBuilder.RenameIndex(
                name: "IX_AdvertImage_AdvertId",
                table: "tbl_AdvertImages",
                newName: "IX_tbl_AdvertImages_AdvertId");

            migrationBuilder.RenameIndex(
                name: "IX_AdvertFilterValue_FilterValuesId",
                table: "tbl_AdvertFilterValues",
                newName: "IX_tbl_AdvertFilterValues_FilterValuesId");

            migrationBuilder.RenameIndex(
                name: "IX_Advert_UserId",
                table: "tbl_Adverts",
                newName: "IX_tbl_Adverts_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_Advert_SettlementRef",
                table: "tbl_Adverts",
                newName: "IX_tbl_Adverts_SettlementRef");

            migrationBuilder.RenameIndex(
                name: "IX_Advert_CategoryId",
                table: "tbl_Adverts",
                newName: "IX_tbl_Adverts_CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_AdminMessage_UserId",
                table: "tbl_AdminMessages",
                newName: "IX_tbl_AdminMessages_UserId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Warehouses",
                table: "tbl_Warehouses",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_UserFavorites",
                table: "tbl_UserFavorites",
                columns: new[] { "FavoriteAdvertsId", "FavoritedByUsersId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Settlements",
                table: "tbl_Settlements",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Regions",
                table: "tbl_Regions",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_RefreshTokens",
                table: "tbl_RefreshTokens",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_FilterValues",
                table: "tbl_FilterValues",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Filters",
                table: "tbl_Filters",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_ChatMessages",
                table: "tbl_ChatMessages",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Chats",
                table: "tbl_Chats",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_CategoryFilters",
                table: "tbl_CategoryFilters",
                columns: new[] { "CategoriesId", "FiltersId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Categories",
                table: "tbl_Categories",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Areas",
                table: "tbl_Areas",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_AdvertImages",
                table: "tbl_AdvertImages",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_AdvertFilterValues",
                table: "tbl_AdvertFilterValues",
                columns: new[] { "AdvertsId", "FilterValuesId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_Adverts",
                table: "tbl_Adverts",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_tbl_AdminMessages",
                table: "tbl_AdminMessages",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AspNetUsers_tbl_Settlements_SettlementRef",
                table: "AspNetUsers",
                column: "SettlementRef",
                principalTable: "tbl_Settlements",
                principalColumn: "Ref");

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_AdminMessages_AspNetUsers_UserId",
                table: "tbl_AdminMessages",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_AdvertFilterValues_tbl_Adverts_AdvertsId",
                table: "tbl_AdvertFilterValues",
                column: "AdvertsId",
                principalTable: "tbl_Adverts",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_AdvertFilterValues_tbl_FilterValues_FilterValuesId",
                table: "tbl_AdvertFilterValues",
                column: "FilterValuesId",
                principalTable: "tbl_FilterValues",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_AdvertImages_tbl_Adverts_AdvertId",
                table: "tbl_AdvertImages",
                column: "AdvertId",
                principalTable: "tbl_Adverts",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Adverts_AspNetUsers_UserId",
                table: "tbl_Adverts",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Adverts_tbl_Categories_CategoryId",
                table: "tbl_Adverts",
                column: "CategoryId",
                principalTable: "tbl_Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Adverts_tbl_Settlements_SettlementRef",
                table: "tbl_Adverts",
                column: "SettlementRef",
                principalTable: "tbl_Settlements",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Categories_tbl_Categories_ParentId",
                table: "tbl_Categories",
                column: "ParentId",
                principalTable: "tbl_Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_CategoryFilters_tbl_Categories_CategoriesId",
                table: "tbl_CategoryFilters",
                column: "CategoriesId",
                principalTable: "tbl_Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_CategoryFilters_tbl_Filters_FiltersId",
                table: "tbl_CategoryFilters",
                column: "FiltersId",
                principalTable: "tbl_Filters",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_ChatMessages_AspNetUsers_SenderId",
                table: "tbl_ChatMessages",
                column: "SenderId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_ChatMessages_tbl_Chats_ChatId",
                table: "tbl_ChatMessages",
                column: "ChatId",
                principalTable: "tbl_Chats",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Chats_AspNetUsers_BuyerId",
                table: "tbl_Chats",
                column: "BuyerId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Chats_AspNetUsers_SellerId",
                table: "tbl_Chats",
                column: "SellerId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Chats_tbl_Adverts_AdvertId",
                table: "tbl_Chats",
                column: "AdvertId",
                principalTable: "tbl_Adverts",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_FilterValues_tbl_Filters_FilterId",
                table: "tbl_FilterValues",
                column: "FilterId",
                principalTable: "tbl_Filters",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_RefreshTokens_AspNetUsers_OlxUserId",
                table: "tbl_RefreshTokens",
                column: "OlxUserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Regions_tbl_Areas_AreaRef",
                table: "tbl_Regions",
                column: "AreaRef",
                principalTable: "tbl_Areas",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Settlements_tbl_Regions_Region",
                table: "tbl_Settlements",
                column: "Region",
                principalTable: "tbl_Regions",
                principalColumn: "Ref");

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_UserFavorites_AspNetUsers_FavoritedByUsersId",
                table: "tbl_UserFavorites",
                column: "FavoritedByUsersId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_UserFavorites_tbl_Adverts_FavoriteAdvertsId",
                table: "tbl_UserFavorites",
                column: "FavoriteAdvertsId",
                principalTable: "tbl_Adverts",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Warehouses_tbl_Settlements_SettlementRef",
                table: "tbl_Warehouses",
                column: "SettlementRef",
                principalTable: "tbl_Settlements",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AspNetUsers_tbl_Settlements_SettlementRef",
                table: "AspNetUsers");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_AdminMessages_AspNetUsers_UserId",
                table: "tbl_AdminMessages");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_AdvertFilterValues_tbl_Adverts_AdvertsId",
                table: "tbl_AdvertFilterValues");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_AdvertFilterValues_tbl_FilterValues_FilterValuesId",
                table: "tbl_AdvertFilterValues");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_AdvertImages_tbl_Adverts_AdvertId",
                table: "tbl_AdvertImages");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Adverts_AspNetUsers_UserId",
                table: "tbl_Adverts");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Adverts_tbl_Categories_CategoryId",
                table: "tbl_Adverts");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Adverts_tbl_Settlements_SettlementRef",
                table: "tbl_Adverts");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Categories_tbl_Categories_ParentId",
                table: "tbl_Categories");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_CategoryFilters_tbl_Categories_CategoriesId",
                table: "tbl_CategoryFilters");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_CategoryFilters_tbl_Filters_FiltersId",
                table: "tbl_CategoryFilters");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_ChatMessages_AspNetUsers_SenderId",
                table: "tbl_ChatMessages");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_ChatMessages_tbl_Chats_ChatId",
                table: "tbl_ChatMessages");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Chats_AspNetUsers_BuyerId",
                table: "tbl_Chats");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Chats_AspNetUsers_SellerId",
                table: "tbl_Chats");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Chats_tbl_Adverts_AdvertId",
                table: "tbl_Chats");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_FilterValues_tbl_Filters_FilterId",
                table: "tbl_FilterValues");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_RefreshTokens_AspNetUsers_OlxUserId",
                table: "tbl_RefreshTokens");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Regions_tbl_Areas_AreaRef",
                table: "tbl_Regions");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Settlements_tbl_Regions_Region",
                table: "tbl_Settlements");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_UserFavorites_AspNetUsers_FavoritedByUsersId",
                table: "tbl_UserFavorites");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_UserFavorites_tbl_Adverts_FavoriteAdvertsId",
                table: "tbl_UserFavorites");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Warehouses_tbl_Settlements_SettlementRef",
                table: "tbl_Warehouses");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Warehouses",
                table: "tbl_Warehouses");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_UserFavorites",
                table: "tbl_UserFavorites");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Settlements",
                table: "tbl_Settlements");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Regions",
                table: "tbl_Regions");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_RefreshTokens",
                table: "tbl_RefreshTokens");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_FilterValues",
                table: "tbl_FilterValues");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Filters",
                table: "tbl_Filters");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Chats",
                table: "tbl_Chats");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_ChatMessages",
                table: "tbl_ChatMessages");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_CategoryFilters",
                table: "tbl_CategoryFilters");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Categories",
                table: "tbl_Categories");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Areas",
                table: "tbl_Areas");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_Adverts",
                table: "tbl_Adverts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_AdvertImages",
                table: "tbl_AdvertImages");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_AdvertFilterValues",
                table: "tbl_AdvertFilterValues");

            migrationBuilder.DropPrimaryKey(
                name: "PK_tbl_AdminMessages",
                table: "tbl_AdminMessages");

            migrationBuilder.RenameTable(
                name: "tbl_Warehouses",
                newName: "Warehous");

            migrationBuilder.RenameTable(
                name: "tbl_UserFavorites",
                newName: "UserFavorites");

            migrationBuilder.RenameTable(
                name: "tbl_Settlements",
                newName: "Settlement");

            migrationBuilder.RenameTable(
                name: "tbl_Regions",
                newName: "Region");

            migrationBuilder.RenameTable(
                name: "tbl_RefreshTokens",
                newName: "RefreshToken");

            migrationBuilder.RenameTable(
                name: "tbl_FilterValues",
                newName: "FilterValue");

            migrationBuilder.RenameTable(
                name: "tbl_Filters",
                newName: "Filter");

            migrationBuilder.RenameTable(
                name: "tbl_Chats",
                newName: "Chat");

            migrationBuilder.RenameTable(
                name: "tbl_ChatMessages",
                newName: "ChatMessage");

            migrationBuilder.RenameTable(
                name: "tbl_CategoryFilters",
                newName: "CategoryFilter");

            migrationBuilder.RenameTable(
                name: "tbl_Categories",
                newName: "Category");

            migrationBuilder.RenameTable(
                name: "tbl_Areas",
                newName: "Area");

            migrationBuilder.RenameTable(
                name: "tbl_Adverts",
                newName: "Advert");

            migrationBuilder.RenameTable(
                name: "tbl_AdvertImages",
                newName: "AdvertImage");

            migrationBuilder.RenameTable(
                name: "tbl_AdvertFilterValues",
                newName: "AdvertFilterValue");

            migrationBuilder.RenameTable(
                name: "tbl_AdminMessages",
                newName: "AdminMessage");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Warehouses_SettlementRef",
                table: "Warehous",
                newName: "IX_Warehous_SettlementRef");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_UserFavorites_FavoritedByUsersId",
                table: "UserFavorites",
                newName: "IX_UserFavorites_FavoritedByUsersId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Settlements_Region",
                table: "Settlement",
                newName: "IX_Settlement_Region");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Regions_AreaRef",
                table: "Region",
                newName: "IX_Region_AreaRef");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_RefreshTokens_OlxUserId",
                table: "RefreshToken",
                newName: "IX_RefreshToken_OlxUserId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_FilterValues_FilterId",
                table: "FilterValue",
                newName: "IX_FilterValue_FilterId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Chats_SellerId",
                table: "Chat",
                newName: "IX_Chat_SellerId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Chats_BuyerId",
                table: "Chat",
                newName: "IX_Chat_BuyerId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Chats_AdvertId",
                table: "Chat",
                newName: "IX_Chat_AdvertId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_ChatMessages_SenderId",
                table: "ChatMessage",
                newName: "IX_ChatMessage_SenderId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_ChatMessages_ChatId",
                table: "ChatMessage",
                newName: "IX_ChatMessage_ChatId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_CategoryFilters_FiltersId",
                table: "CategoryFilter",
                newName: "IX_CategoryFilter_FiltersId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Categories_ParentId",
                table: "Category",
                newName: "IX_Category_ParentId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Adverts_UserId",
                table: "Advert",
                newName: "IX_Advert_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Adverts_SettlementRef",
                table: "Advert",
                newName: "IX_Advert_SettlementRef");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_Adverts_CategoryId",
                table: "Advert",
                newName: "IX_Advert_CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_AdvertImages_AdvertId",
                table: "AdvertImage",
                newName: "IX_AdvertImage_AdvertId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_AdvertFilterValues_FilterValuesId",
                table: "AdvertFilterValue",
                newName: "IX_AdvertFilterValue_FilterValuesId");

            migrationBuilder.RenameIndex(
                name: "IX_tbl_AdminMessages_UserId",
                table: "AdminMessage",
                newName: "IX_AdminMessage_UserId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Warehous",
                table: "Warehous",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserFavorites",
                table: "UserFavorites",
                columns: new[] { "FavoriteAdvertsId", "FavoritedByUsersId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Settlement",
                table: "Settlement",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Region",
                table: "Region",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_RefreshToken",
                table: "RefreshToken",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_FilterValue",
                table: "FilterValue",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Filter",
                table: "Filter",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Chat",
                table: "Chat",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ChatMessage",
                table: "ChatMessage",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CategoryFilter",
                table: "CategoryFilter",
                columns: new[] { "CategoriesId", "FiltersId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Category",
                table: "Category",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Area",
                table: "Area",
                column: "Ref");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Advert",
                table: "Advert",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AdvertImage",
                table: "AdvertImage",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AdvertFilterValue",
                table: "AdvertFilterValue",
                columns: new[] { "AdvertsId", "FilterValuesId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_AdminMessage",
                table: "AdminMessage",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AdminMessage_AspNetUsers_UserId",
                table: "AdminMessage",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Advert_AspNetUsers_UserId",
                table: "Advert",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Advert_Category_CategoryId",
                table: "Advert",
                column: "CategoryId",
                principalTable: "Category",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Advert_Settlement_SettlementRef",
                table: "Advert",
                column: "SettlementRef",
                principalTable: "Settlement",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AdvertFilterValue_Advert_AdvertsId",
                table: "AdvertFilterValue",
                column: "AdvertsId",
                principalTable: "Advert",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AdvertFilterValue_FilterValue_FilterValuesId",
                table: "AdvertFilterValue",
                column: "FilterValuesId",
                principalTable: "FilterValue",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AdvertImage_Advert_AdvertId",
                table: "AdvertImage",
                column: "AdvertId",
                principalTable: "Advert",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_AspNetUsers_Settlement_SettlementRef",
                table: "AspNetUsers",
                column: "SettlementRef",
                principalTable: "Settlement",
                principalColumn: "Ref");

            migrationBuilder.AddForeignKey(
                name: "FK_Category_Category_ParentId",
                table: "Category",
                column: "ParentId",
                principalTable: "Category",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_CategoryFilter_Category_CategoriesId",
                table: "CategoryFilter",
                column: "CategoriesId",
                principalTable: "Category",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CategoryFilter_Filter_FiltersId",
                table: "CategoryFilter",
                column: "FiltersId",
                principalTable: "Filter",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Chat_Advert_AdvertId",
                table: "Chat",
                column: "AdvertId",
                principalTable: "Advert",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Chat_AspNetUsers_BuyerId",
                table: "Chat",
                column: "BuyerId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Chat_AspNetUsers_SellerId",
                table: "Chat",
                column: "SellerId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ChatMessage_AspNetUsers_SenderId",
                table: "ChatMessage",
                column: "SenderId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ChatMessage_Chat_ChatId",
                table: "ChatMessage",
                column: "ChatId",
                principalTable: "Chat",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FilterValue_Filter_FilterId",
                table: "FilterValue",
                column: "FilterId",
                principalTable: "Filter",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_RefreshToken_AspNetUsers_OlxUserId",
                table: "RefreshToken",
                column: "OlxUserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Region_Area_AreaRef",
                table: "Region",
                column: "AreaRef",
                principalTable: "Area",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement",
                column: "Region",
                principalTable: "Region",
                principalColumn: "Ref");

            migrationBuilder.AddForeignKey(
                name: "FK_UserFavorites_Advert_FavoriteAdvertsId",
                table: "UserFavorites",
                column: "FavoriteAdvertsId",
                principalTable: "Advert",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserFavorites_AspNetUsers_FavoritedByUsersId",
                table: "UserFavorites",
                column: "FavoritedByUsersId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Warehous_Settlement_SettlementRef",
                table: "Warehous",
                column: "SettlementRef",
                principalTable: "Settlement",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
