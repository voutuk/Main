using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class Change_newpost_delete_behavior : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Settlements_tbl_Regions_Region",
                table: "tbl_Settlements");

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Settlements_tbl_Regions_Region",
                table: "tbl_Settlements",
                column: "Region",
                principalTable: "tbl_Regions",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_tbl_Settlements_tbl_Regions_Region",
                table: "tbl_Settlements");

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_Settlements_tbl_Regions_Region",
                table: "tbl_Settlements",
                column: "Region",
                principalTable: "tbl_Regions",
                principalColumn: "Ref");
        }
    }
}
