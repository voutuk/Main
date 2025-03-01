using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Olx.DAL.Migrations
{
    /// <inheritdoc />
    public partial class AddUserFavorites : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "UserFavorites",
                columns: table => new
                {
                    FavoriteAdvertsId = table.Column<int>(type: "integer", nullable: false),
                    FavoritedByUsersId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserFavorites", x => new { x.FavoriteAdvertsId, x.FavoritedByUsersId });
                    table.ForeignKey(
                        name: "FK_UserFavorites_Advert_FavoriteAdvertsId",
                        column: x => x.FavoriteAdvertsId,
                        principalTable: "Advert",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserFavorites_AspNetUsers_FavoritedByUsersId",
                        column: x => x.FavoritedByUsersId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserFavorites_FavoritedByUsersId",
                table: "UserFavorites",
                column: "FavoritedByUsersId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UserFavorites");
        }
    }
}
