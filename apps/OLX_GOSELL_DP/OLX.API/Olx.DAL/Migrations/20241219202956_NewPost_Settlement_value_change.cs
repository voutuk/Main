using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class NewPost_Settlement_value_change : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Settlement_Region_RegionRef",
                table: "Settlement");

            migrationBuilder.RenameColumn(
                name: "RegionRef",
                table: "Settlement",
                newName: "SettlementRegionRef");

            migrationBuilder.RenameIndex(
                name: "IX_Settlement_RegionRef",
                table: "Settlement",
                newName: "IX_Settlement_SettlementRegionRef");

            migrationBuilder.AddForeignKey(
                name: "FK_Settlement_Region_SettlementRegionRef",
                table: "Settlement",
                column: "SettlementRegionRef",
                principalTable: "Region",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Settlement_Region_SettlementRegionRef",
                table: "Settlement");

            migrationBuilder.RenameColumn(
                name: "SettlementRegionRef",
                table: "Settlement",
                newName: "RegionRef");

            migrationBuilder.RenameIndex(
                name: "IX_Settlement_SettlementRegionRef",
                table: "Settlement",
                newName: "IX_Settlement_RegionRef");

            migrationBuilder.AddForeignKey(
                name: "FK_Settlement_Region_RegionRef",
                table: "Settlement",
                column: "RegionRef",
                principalTable: "Region",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
