using NpgsqlTypes;

namespace DbContexts.Enums
{
    public enum UserStatus
    {
        [PgName("Active")]
        Active,

        [PgName("DeActive")]
        DeActive,

        [PgName("Deleted")]
        Deleted
    }
}