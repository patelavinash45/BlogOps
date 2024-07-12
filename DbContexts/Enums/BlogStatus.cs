using NpgsqlTypes;

namespace DbContexts.Enums
{
    public enum BlogStatus
    {
        [PgName("Pending")]
        Pending,

        [PgName("Approved")]
        Approved,

        [PgName("Rejected")]
        Rejected,

        [PgName("Deleted")]
        Deleted,

        [PgName("Draft")]
        Draft,

        All
    }
}
