using NpgsqlTypes;

namespace DbContexts.Enums
{
    public enum BlogStatus
    {
        [PgName("Pending")]
        Pending, // 0 

        [PgName("Approved")]
        Approved, // 1

        [PgName("Rejected")]
        Rejected, // 2

        [PgName("Deleted")]
        Deleted, // 3

        [PgName("Draft")]
        Draft, // 4 

        All // 5
    }
}
