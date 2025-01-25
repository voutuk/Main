using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class Add_Message_to_AdminMessage : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_tbl_AdminMessages_AspNetUsers_UserId",
                table: "tbl_AdminMessages");

            migrationBuilder.DropColumn(
                name: "Content",
                table: "tbl_AdminMessages");

            migrationBuilder.DropColumn(
                name: "FromAdmin",
                table: "tbl_AdminMessages");

            migrationBuilder.DropColumn(
                name: "Subject",
                table: "tbl_AdminMessages");

            migrationBuilder.AlterColumn<int>(
                name: "UserId",
                table: "tbl_AdminMessages",
                type: "integer",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "integer");

            migrationBuilder.AddColumn<int>(
                name: "MessageId",
                table: "tbl_AdminMessages",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "tbl_Messages",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Content = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: false),
                    Subject = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_tbl_Messages", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_tbl_AdminMessages_MessageId",
                table: "tbl_AdminMessages",
                column: "MessageId");

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_AdminMessages_AspNetUsers_UserId",
                table: "tbl_AdminMessages",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_AdminMessages_tbl_Messages_MessageId",
                table: "tbl_AdminMessages",
                column: "MessageId",
                principalTable: "tbl_Messages",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_tbl_AdminMessages_AspNetUsers_UserId",
                table: "tbl_AdminMessages");

            migrationBuilder.DropForeignKey(
                name: "FK_tbl_AdminMessages_tbl_Messages_MessageId",
                table: "tbl_AdminMessages");

            migrationBuilder.DropTable(
                name: "tbl_Messages");

            migrationBuilder.DropIndex(
                name: "IX_tbl_AdminMessages_MessageId",
                table: "tbl_AdminMessages");

            migrationBuilder.DropColumn(
                name: "MessageId",
                table: "tbl_AdminMessages");

            migrationBuilder.AlterColumn<int>(
                name: "UserId",
                table: "tbl_AdminMessages",
                type: "integer",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "integer",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Content",
                table: "tbl_AdminMessages",
                type: "character varying(2000)",
                maxLength: 2000,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<bool>(
                name: "FromAdmin",
                table: "tbl_AdminMessages",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "Subject",
                table: "tbl_AdminMessages",
                type: "character varying(200)",
                maxLength: 200,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_tbl_AdminMessages_AspNetUsers_UserId",
                table: "tbl_AdminMessages",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
