using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class NewPost_entities : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "SettlementRef",
                table: "AspNetUsers",
                type: "character varying(36)",
                unicode: false,
                maxLength: 36,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "SettlementRef",
                table: "Advert",
                type: "character varying(36)",
                unicode: false,
                maxLength: 36,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "Area",
                columns: table => new
                {
                    Ref = table.Column<string>(type: "character varying(36)", unicode: false, maxLength: 36, nullable: false),
                    RegionType = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Description = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Area", x => x.Ref);
                });

            migrationBuilder.CreateTable(
                name: "Region",
                columns: table => new
                {
                    Ref = table.Column<string>(type: "character varying(36)", unicode: false, maxLength: 36, nullable: false),
                    RegionType = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    AreaRef = table.Column<string>(type: "character varying(36)", unicode: false, maxLength: 36, nullable: false),
                    Description = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Region", x => x.Ref);
                    table.ForeignKey(
                        name: "FK_Region_Area_AreaRef",
                        column: x => x.AreaRef,
                        principalTable: "Area",
                        principalColumn: "Ref",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Settlement",
                columns: table => new
                {
                    Ref = table.Column<string>(type: "character varying(36)", unicode: false, maxLength: 36, nullable: false),
                    SettlementTypeDescription = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    RegionRef = table.Column<string>(type: "character varying(36)", unicode: false, maxLength: 36, nullable: false),
                    Description = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Settlement", x => x.Ref);
                    table.ForeignKey(
                        name: "FK_Settlement_Region_RegionRef",
                        column: x => x.RegionRef,
                        principalTable: "Region",
                        principalColumn: "Ref",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Warehous",
                columns: table => new
                {
                    Ref = table.Column<string>(type: "character varying(36)", unicode: false, maxLength: 36, nullable: false),
                    Phone = table.Column<string>(type: "text", nullable: false),
                    SettlementRef = table.Column<string>(type: "character varying(36)", unicode: false, maxLength: 36, nullable: false),
                    Description = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Warehous", x => x.Ref);
                    table.ForeignKey(
                        name: "FK_Warehous_Settlement_SettlementRef",
                        column: x => x.SettlementRef,
                        principalTable: "Settlement",
                        principalColumn: "Ref",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_SettlementRef",
                table: "AspNetUsers",
                column: "SettlementRef");

            migrationBuilder.CreateIndex(
                name: "IX_Advert_SettlementRef",
                table: "Advert",
                column: "SettlementRef");

            migrationBuilder.CreateIndex(
                name: "IX_Region_AreaRef",
                table: "Region",
                column: "AreaRef");

            migrationBuilder.CreateIndex(
                name: "IX_Settlement_RegionRef",
                table: "Settlement",
                column: "RegionRef");

            migrationBuilder.CreateIndex(
                name: "IX_Warehous_SettlementRef",
                table: "Warehous",
                column: "SettlementRef");

            migrationBuilder.AddForeignKey(
                name: "FK_Advert_Settlement_SettlementRef",
                table: "Advert",
                column: "SettlementRef",
                principalTable: "Settlement",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AspNetUsers_Settlement_SettlementRef",
                table: "AspNetUsers",
                column: "SettlementRef",
                principalTable: "Settlement",
                principalColumn: "Ref");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Advert_Settlement_SettlementRef",
                table: "Advert");

            migrationBuilder.DropForeignKey(
                name: "FK_AspNetUsers_Settlement_SettlementRef",
                table: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "Warehous");

            migrationBuilder.DropTable(
                name: "Settlement");

            migrationBuilder.DropTable(
                name: "Region");

            migrationBuilder.DropTable(
                name: "Area");

            migrationBuilder.DropIndex(
                name: "IX_AspNetUsers_SettlementRef",
                table: "AspNetUsers");

            migrationBuilder.DropIndex(
                name: "IX_Advert_SettlementRef",
                table: "Advert");

            migrationBuilder.DropColumn(
                name: "SettlementRef",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "SettlementRef",
                table: "Advert");
        }
    }
}
