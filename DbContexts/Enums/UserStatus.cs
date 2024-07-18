using NpgsqlTypes;

namespace DbContexts.Enums
{
    public enum UserStatus
    {
        [PgName("Active")]
        Active,

        [PgName("Deactive")]
        DeActive,

        [PgName("Deleted")]
        Deleted
    }
}