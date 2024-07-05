using DbContexts.Enums;

namespace Dtos.Response
{
    public class BlogResponseDto
    {
        public int Id { get; set; }

        public string? Title { get; set; }

        public string? Content { get; set; }

        public string? AdminComment { get; set; }

        public BlogStatus Status { get; set; }

        public DateTime CreatedDate { get; set; }
    }
}