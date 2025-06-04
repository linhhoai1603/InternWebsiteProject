package utils;

import models.AccountUser;
import models.User;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountUserMapper implements RowMapper<AccountUser> {
    @Override
    public AccountUser map(ResultSet rs, StatementContext ctx) throws SQLException {
        AccountUser acc = new AccountUser();
        acc.setId(rs.getInt("id"));
        acc.setUsername(rs.getString("username"));
        acc.setPassword(rs.getString("password"));
        acc.setRole(rs.getInt("idRole")); // hoặc rs.getInt("role") nếu tên cột là "role"
        acc.setLocked(rs.getInt("locked"));
        acc.setCode(rs.getString("code"));

        User user = new User();
        user.setId(rs.getInt("idUser"));  // ánh xạ từ idUser trong bảng account_users
        acc.setUser(user);

        return acc;
    }
}
