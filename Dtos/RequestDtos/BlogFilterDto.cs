using DbContexts.Enums;

namespace Dtos.RequestDtos
{
    public class BlogFilterDto
    {
        public BlogStatus? Status { get; set; }

        public string? SearchContent { get; set; }
    }
}