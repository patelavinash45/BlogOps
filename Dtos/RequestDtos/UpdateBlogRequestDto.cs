using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;

namespace Dtos.RequestDtos
{
    public class UpdateBlogRequestDto
    {
        [Range(1, int.MaxValue)]
        public int Id { get; set; }

        [StringLength(128)]
        public string? Title { get; set; }

        public string? Content { get; set; }

        [StringLength(256)]
        public string? AdminComment { get; set; }

        public BlogStatus Status { get; set; }

        public List<int>? BlogsCategoryIds { get; set; }
    }
}

