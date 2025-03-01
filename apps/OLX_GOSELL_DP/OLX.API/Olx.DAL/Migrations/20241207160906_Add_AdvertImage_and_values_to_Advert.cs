using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class Add_AdvertImage_and_values_to_Advert : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Advert_AspNetUsers_OlxUserId",
                table: "Advert");

            migrationBuilder.DropForeignKey(
                name: "FK_Category_Category_ParentId",
                table: "Category");

            migrationBuilder.DropIndex(
                name: "IX_Advert_OlxUserId",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "OlxUserId",
                table: "Advert");

            migrationBuilder.AddColumn<string>(
                name: "ContactEmail",
                table: "Advert",
                type: "character varying(128)",
                maxLength: 128,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "ContactPersone",
                table: "Advert",
                type: "character varying(128)",
                maxLength: 128,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "Date",
                table: "Advert",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "Advert",
                type: "character varying(5000)",
                maxLength: 5000,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<bool>(
                name: "IsContractPrice",
                table: "Advert",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "PhoneNumber",
                table: "Advert",
                type: "character varying(13)",
                maxLength: 13,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<decimal>(
                name: "Price",
                table: "Advert",
                type: "numeric",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AddColumn<string>(
                name: "Title",
                table: "Advert",
                type: "character varying(256)",
                maxLength: 256,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "UserId",
                table: "Advert",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "AdvertImage",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    AdvertId = table.Column<int>(type: "integer", nullable: false),
                    Position = table.Column<int>(type: "integer", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AdvertImage", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AdvertImage_Advert_AdvertId",
                        column: x => x.AdvertId,
                        principalTable: "Advert",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Advert_UserId",
                table: "Advert",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AdvertImage_AdvertId",
                table: "AdvertImage",
                column: "AdvertId");

            migrationBuilder.AddForeignKey(
                name: "FK_Advert_AspNetUsers_UserId",
                table: "Advert",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Category_Category_ParentId",
                table: "Category",
                column: "ParentId",
                principalTable: "Category",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Advert_AspNetUsers_UserId",
                table: "Advert");

            migrationBuilder.DropForeignKey(
                name: "FK_Category_Category_ParentId",
                table: "Category");

            migrationBuilder.DropTable(
                name: "AdvertImage");

            migrationBuilder.DropIndex(
                name: "IX_Advert_UserId",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "ContactEmail",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "ContactPersone",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "Date",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "Description",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "IsContractPrice",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "PhoneNumber",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "Price",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "Title",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Advert");

            migrationBuilder.AddColumn<int>(
                name: "OlxUserId",
                table: "Advert",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Advert_OlxUserId",
                table: "Advert",
                column: "OlxUserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Advert_AspNetUsers_OlxUserId",
                table: "Advert",
                column: "OlxUserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Category_Category_ParentId",
                table: "Category",
                column: "ParentId",
                principalTable: "Category",
                principalColumn: "Id");
        }
    }
}
