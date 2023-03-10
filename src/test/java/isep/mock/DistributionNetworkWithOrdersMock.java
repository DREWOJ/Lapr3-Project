package isep.mock;

import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import isep.controller.LoadDistributionNetworkController;
import isep.model.DailyData;
import isep.model.DistributionNetwork;
import isep.model.Product;
import isep.model.store.EntityStore;
import isep.utils.CSVReader;

public class DistributionNetworkWithOrdersMock {
  private final static String FILE_PATH = "./src/test/resources/distancesSampleV2.csv";

  public DistributionNetwork distributionNetworkWithOrdersMockSmall()
      throws FileNotFoundException {

    EntityStore store = new EntityStoreMock().mockSimpleEntityStoreSmall();

    Product banana = new Product("banana");
    Product orange = new Product("orange");
    Product lemon = new Product("lemon");

    DailyData dataProducer = new DailyData();
    DailyData dataProducer1 = new DailyData();
    DailyData dataProducer2 = new DailyData();

    Map<Product, Double> mapProducer = new HashMap<>();
    mapProducer.put(banana, 100.);
    mapProducer.put(orange, 200.);
    mapProducer.put(lemon, 300.);

    dataProducer.addDayData(1, mapProducer);
    dataProducer.addDayData(4, mapProducer);

    Map<Product, Double> mapProducer1 = new HashMap<>();
    mapProducer1.put(banana, 300.);
    mapProducer1.put(orange, 200.);
    mapProducer1.put(lemon, 100.);

    dataProducer1.addDayData(1, mapProducer1);

    Map<Product, Double> mapProducer1b = new HashMap<>();
    mapProducer1b.put(banana, 300.);
    mapProducer1b.put(orange, 200.);
    mapProducer1b.put(lemon, 100.);

    dataProducer1.addDayData(2, mapProducer1b);

    Map<Product, Double> mapProducer2 = new HashMap<>();
    mapProducer2.put(banana, 300.);
    mapProducer2.put(orange, 200.);
    mapProducer2.put(lemon, 100.);

    dataProducer2.addDayData(3, mapProducer2);

    Map<Product, Double> mapProducer2b = new HashMap<>();
    mapProducer2b.put(banana, 300.);
    mapProducer2b.put(orange, 200.);
    mapProducer2b.put(lemon, 100.);
    dataProducer2.addDayData(4, mapProducer2b);

    store.getEntityByLocalizationId("CT5").setDailyData(dataProducer);
    store.getEntityByLocalizationId("CT6").setDailyData(dataProducer1);
    store.getEntityByLocalizationId("CT8").setDailyData(dataProducer2);

    /*
     * | -------------------- |
     * | --- CLIENTS DATA --- |
     * | -------------------- |
     */

    DailyData dataClient = new DailyData();
    DailyData dataClient1 = new DailyData();
    DailyData dataClient2 = new DailyData();

    Map<Product, Double> mapClient = new HashMap<>();
    mapClient.put(banana, 100.);

    dataClient.addDayData(1, mapClient);

    Map<Product, Double> mapClient1 = new HashMap<>();
    mapClient1.put(orange, 200.);
    mapClient1.put(lemon, 100.);

    dataClient1.addDayData(1, mapClient1);

    Map<Product, Double> mapClient2 = new HashMap<>();
    mapClient2.put(orange, 200.);
    mapClient2.put(lemon, 100.);
    mapClient2.put(banana, 150.);

    Map<Product, Double> mapClient3 = new HashMap<>();
    mapClient3.put(orange, 200.);
    mapClient3.put(lemon, 100.);
    mapClient3.put(banana, 150.);

    dataClient2.addDayData(3, mapClient2);
    dataClient2.addDayData(4, mapClient3);

    store.getEntityByLocalizationId("CT1").setDailyData(dataClient);
    store.getEntityByLocalizationId("CT2").setDailyData(dataClient1);
    store.getEntityByLocalizationId("CT4").setDailyData(dataClient2);

    CSVReader csvReader = new CSVReader(FILE_PATH);
    List<Map<String, String>> list = csvReader.read();

    return new LoadDistributionNetworkController(store, list).loadDistributionNetwork();
  }

}
