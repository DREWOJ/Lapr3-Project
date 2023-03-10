package isep.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import java.util.ArrayList;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import isep.mock.ExpeditionListMock;
import isep.shared.exceptions.InvalidHubException;

public class ExpeditionListTest {
  private static ExpeditionList expList;
  private static Client mockClient;
  private static Enterprise mockHub;

  @BeforeAll
  public static void setup() throws InvalidHubException {
    expList = new ExpeditionListMock().mockSimpleExpeditionList();
    mockClient = new Client("id2", 0, 0, "C01");
    mockHub = new Enterprise("id1", 0, 0, "E01");
    mockHub.makeHub();
  }

  @Test
  public void testAddBasketWithNull() {
    assertThrows(IllegalArgumentException.class, () -> {
      expList.addBasket(null);
    });
  }

  @Test
  public void testCreateExpeditionListWithInvalidDay() {
    assertThrows(IllegalArgumentException.class, () -> {
      new ExpeditionList(-1);
    });
  }

  @Test
  public void testGetNumberOfFullySatisfiedProducts() {
    assertEquals(2, expList.getNumberOfFullySatisfiedProducts(expList.getBaskets().get(0)));
    assertEquals(1, expList.getNumberOfFullySatisfiedProducts(expList.getBaskets().get(1)));
  }

  @Test
  public void testGetNumberOfPartiallySatisfiedProducts() {
    assertEquals(1, expList.getNumberOfPartiallySatisfiedProducts(expList.getBaskets().get(0)));
    assertEquals(1, expList.getNumberOfPartiallySatisfiedProducts(expList.getBaskets().get(1)));
  }

  @Test
  public void testGetNumberOfNotSatisfiedProducts() {
    assertEquals(0, expList.getNumberOfNotSatisfiedProducts(expList.getBaskets().get(0)));
    assertEquals(1, expList.getNumberOfNotSatisfiedProducts(expList.getBaskets().get(1)));
  }

  @Test
  public void testGetPercentageOfFullySatisfiedProducts() {
    assertEquals(0.867, expList.getBasketFulfillmentPercentage(expList.getBaskets().get(0)), .001);
    assertEquals(0.067, expList.getBasketFulfillmentPercentage(expList.getBaskets().get(1)), .001);
  }

  @Test
  public void getNumberOfDistinctProducersForBasket() {
    assertEquals(1, expList.getNumberOfDistinctProducersForBasket(expList.getBaskets().get(0)));
    assertEquals(2, expList.getNumberOfDistinctProducersForBasket(expList.getBaskets().get(1)));
  }

  @Test
  public void testGetNumberOfFullySuppliedBasketsByProducer() {
    assertEquals(1, expList
        .getNumberOfFullySuppliedBasketsByProducer(new ArrayList<>(expList.getProducers()).get(0)));
    assertEquals(0, expList
        .getNumberOfFullySuppliedBasketsByProducer(new ArrayList<>(expList.getProducers()).get(1)));
  }

  @Test
  public void testGetNumberOfPartiallySuppliedBasketsByProducer() {
    assertEquals(1, expList.getNumberOfPartiallySuppliedBasketsByProducer(
        new ArrayList<>(expList.getProducers()).get(0)));
    assertEquals(1, expList.getNumberOfPartiallySuppliedBasketsByProducer(
        new ArrayList<>(expList.getProducers()).get(1)));
  }

  @Test
  public void testGetNumberOfFullyFulfilledBasketsByClient() {
    assertEquals(0,
        expList.getNumberOfFullyFulfilledBasketsByClient(new Client("id2", 0, 0, "C01")));
  }

  @Test
  public void testGetNumberOfPartiallyFulfilledBasketsByClient() {
    assertEquals(0, expList.getNumberOfPartiallyFulfilledBasketsByClient(mockClient));
  }

  @Test
  public void testGetProducersThatSupplyAllClientsBaskets() {
    assertEquals(1, expList.getNumberOfDistinctProducersThatSupplyAllClientsBasket(mockClient));
  }

  @Test
  public void testGetNumberOfDistinctClientsFromProducer() {
    assertEquals(2,
        expList.getNumberOfDistinctClients(new ArrayList<>(expList.getProducers()).get(0)));
    assertEquals(1,
        expList.getNumberOfDistinctClients(new ArrayList<>(expList.getProducers()).get(1)));
  }

  @Test
  public void testGetNumberOfDistinctHubs() {
    assertEquals(1,
        expList.getNumberOfDistinctHubs(new ArrayList<>(expList.getProducers()).get(0)));
    assertEquals(1,
        expList.getNumberOfDistinctHubs(new ArrayList<>(expList.getProducers()).get(1)));
  }

  @Test
  public void testGetNumberOfDistinctClientsFromHub() {
    assertEquals(2, expList.getNumberOfDistinctClients(mockHub));
  }

  @Test
  public void testGetClients() {
    assertEquals(2, expList.getClients().size());
  }

  @Test
  public void testGetNumberOfDistinctProducers() {
    assertEquals(2, expList.getNumberOfDistinctProducers(mockHub));
  }

  @Test
  public void testGetNumberOfOutOfStockProducts() {
    assertEquals(2,
        expList.getNumberOfOutOfStockProducts(new ArrayList<>(expList.getProducers()).get(0)));
    assertEquals(0,
        expList.getNumberOfOutOfStockProducts(new ArrayList<>(expList.getProducers()).get(1)));
  }

  @Test
  public void testGetNumberOfBaskets() {
    assertEquals(2, expList.getNumberOfBaskets());
  }
}
