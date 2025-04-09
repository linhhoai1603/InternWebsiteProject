package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class WareHouseDao {
    Jdbi jdbi;
    public WareHouseDao() {
        jdbi = DBConnection.getConnetion();
    }

}
