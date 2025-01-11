package dao;

import connection.DBConnection;
import models.TechnicalInfo;
import org.jdbi.v3.core.Jdbi;

public class TechnicalDAO {
    Jdbi jdbi;
    public TechnicalDAO(){
        jdbi = DBConnection.getConnetion();
    }

    public int addTechnical(TechnicalInfo technicalInfo) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO technical_information (specifications, manufactureDate) " +
                                "VALUES (?, ?)")
                        .bind(0, technicalInfo.getSpecification())
                        .bind(1,technicalInfo.getManufactureDate())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one());
    }
}
