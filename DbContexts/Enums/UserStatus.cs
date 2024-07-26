using NpgsqlTypes;

namespace DbContexts.Enums;

public enum UserStatus
{
    [PgName("Active")]
    Active, // 0

    [PgName("Deactive")]
    DeActive, // 1

    [PgName("Deleted")]
    Deleted, // 2

    All, // 3
}
