using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class Set_SettlementRegion_nullable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement");

            migrationBuilder.AlterColumn<string>(
                name: "Region",
                table: "Settlement",
                type: "character varying(36)",
                unicode: false,
                maxLength: 36,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(36)",
                oldUnicode: false,
                oldMaxLength: 36);

            migrationBuilder.AddForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement",
                column: "Region",
                principalTable: "Region",
                principalColumn: "Ref");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement");

            migrationBuilder.AlterColumn<string>(
                name: "Region",
                table: "Settlement",
                type: "character varying(36)",
                unicode: false,
                maxLength: 36,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(36)",
                oldUnicode: false,
                oldMaxLength: 36,
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Settlement_Region_Region",
                table: "Settlement",
                column: "Region",
                principalTable: "Region",
                principalColumn: "Ref",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
