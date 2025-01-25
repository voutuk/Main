using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class NewPost_Settlement_value_change2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Settlement_Region_SettlementRegionRef",
                table: "Settlement");

            migrationBuilder.RenameColumn(
                name: "SettlementRegionRef",
                table: "Settlement",
                newName: "Region");

            migrationBuilder.RenameIndex(
                name: "IX_Settlement_SettlementRegionRef",
                table: "Settlement",
                newName: "IX_Settlement_Region");

            migrationBuilder.AddForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement",
                column: "Region",
                principalTable: "Region",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement");

            migrationBuilder.RenameColumn(
                name: "Region",
                table: "Settlement",
                newName: "SettlementRegionRef");

            migrationBuilder.RenameIndex(
                name: "IX_Settlement_Region",
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
    }
}
