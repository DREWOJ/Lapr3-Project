package isep.controller;

import java.io.FileNotFoundException;
import java.util.List;
import java.util.Map;

import isep.model.Company;
import isep.model.mapper.BasketsMapper;
import isep.model.store.EntityStore;
import isep.utils.CSVReader;

/**
 * US 307 - Controller for loading baskets from a CSV file.
 *
 * @author Ricardo Moreira <1211285@isep.ipp.pt>
 */
public class LoadBasketsController {
  private String filename;
  private Company company;

  public LoadBasketsController() {
    this.filename = null;
    this.company = App.getInstance().getCompany();
  }

  public LoadBasketsController(String filename) {
    this.filename = filename;
    this.company = App.getInstance().getCompany();
  }

  public LoadBasketsController(String filename, Company company) {
    this.filename = filename;
    this.company = company;
  }

  public void setFilename(String filename) {
    this.filename = filename;
  }

  public List<Map<String, String>> readData() throws FileNotFoundException {
    CSVReader csvReader = new CSVReader(filename);
    return csvReader.read();
  }

  public int mapBaskets(List<Map<String, String>> data, EntityStore entityStore) {
    return BasketsMapper.toPlan(data, entityStore);
  }

  public boolean isNetworkEmpty() {
    return company.getDistributionNetwork().getEntities().isEmpty();
  }
}
