package isep.model;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class ReceivedProducts {
  private Map<Producer, Map<Product, Integer>> received;

  public ReceivedProducts() {
    this.received = new TreeMap<>();
  }

  public void addProduct(Producer producer, Product product, Integer quantity) {
    if (producer == null)
      throw new IllegalArgumentException("Producer cannot be null");

    if (product == null)
      throw new IllegalArgumentException("Product cannot be null");

    if (quantity == null)
      throw new IllegalArgumentException("Quantity cannot be null");

    Map<Product, Integer> producerProducts = received.get(producer);

    if (producerProducts == null)
      producerProducts = new HashMap<>();

    Integer currentQuantity = producerProducts.get(product);

    if (currentQuantity != null)
      throw new IllegalArgumentException("Product already exists");
    producerProducts.put(product, quantity);

    received.put(producer, producerProducts);
  }

  public void setProduct(Producer producer, Product product, Integer quantity){
    if (producer == null)
      throw new IllegalArgumentException("Producer cannot be null");

    if (product == null)
      throw new IllegalArgumentException("Product cannot be null");
    
    if (quantity == null)
      throw new IllegalArgumentException("Quantity cannot be null");
      
    if(this.received.containsKey(producer)){
      this.received.get(producer).put(product, quantity);
    }else{
      Map<Product, Integer> products = new TreeMap<>();
      products.put(product, quantity);
      this.received.put(producer, products);
    }

  }

  public void addAllProducts(Producer producer, Map<Product, Integer> products) {
    if (producer == null)
      throw new IllegalArgumentException("Producer cannot be null");

    if (products == null)
      throw new IllegalArgumentException("Products cannot be null");

    received.put(producer, products);
  }

  public int getQuantityOfSuppliedProduct(Producer producer, Product product) {
    if (producer == null)
      throw new IllegalArgumentException("Producer cannot be null");

    if (product == null)
      throw new IllegalArgumentException("Product cannot be null");

    if (!received.containsKey(producer))
      throw new IllegalArgumentException("Producer does not exist");

    Map<Product, Integer> receivedProducts = received.get(producer);

    if (!receivedProducts.containsKey(product))
      throw new IllegalArgumentException("Product does not exist");

    return receivedProducts.get(product);
  }

  public Set<Producer> getProducers() {
    Set<Producer> producers = new LinkedHashSet<>();

    for (Producer producer : received.keySet())
      producers.add(producer);

    return producers;
  }

  public boolean matchesProductQuantity(Product product, int quantity) {
    for (Producer producer : received.keySet()) {
      Map<Product, Integer> receivedProducts = received.get(producer);

      if (receivedProducts.get(product) == null)
        continue;

      if (receivedProducts.get(product).equals(quantity))
        return true;
    }

    return false;
  }

  public boolean hasNotReceivedProduct(Product product) {
    for (Producer producer : received.keySet()) {
      Map<Product, Integer> receivedProducts = received.get(producer);

      if (receivedProducts.get(product) == null)
        continue;

      if (receivedProducts.get(product) == 0)
        return true;
    }

    return false;
  }

  public int getNumberOfDistinctProducers() {
    return received.size();
  }
}