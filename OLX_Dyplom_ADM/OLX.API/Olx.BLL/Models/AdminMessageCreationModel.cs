﻿
namespace Olx.BLL.Models
{
    public class AdminMessageCreationModel
    {
        public string Content { get; init; } = string.Empty;
        public string Subject { get; init; } = string.Empty;
        public int? UserId { get; init; }
        public IEnumerable<int>? UserIds { get; init; }

    }
}
