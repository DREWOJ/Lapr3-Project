package isep.model;

import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import isep.controller.DefineHubsController;
import isep.controller.ExpeditionPathController;
import isep.shared.exceptions.InvalidHubException;
import isep.shared.exceptions.InvalidNumberOfHubsException;
import isep.shared.exceptions.InvalidOrderException;
import isep.shared.exceptions.InvalidProductNameException;

/**
 * Tests for ExpeditionPath class.
 * 
 * @author Tomás Russo <1211288@isep.ipp.pt>
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class ExpeditionPathTest {
  private DistributionNetwork distributionNetwork;
  private ExpeditionList expeditionList;

  private Basket dAliceBasket;
  private Basket dManuelaBasket;
  private Basket dLuisaBasket;

  @BeforeAll
  public void setUp() throws FileNotFoundException, InvalidNumberOfHubsException, InvalidProductNameException,
      InvalidOrderException, InvalidHubException {
    this.distributionNetwork = new DistributionNetwork();

    Product macaDeAlcobaca = new Product("Maca de Alcobaca");
    Product bananaDaMadeira = new Product("Banana da Madeira");
    Product batataVermelha = new Product("Batata Vermelha");

    // Porto coordinates
    Producer srManuelPorto = new Producer("SR_MANUEL_PORTO", 41.14961, -8.61099, "OPO");
    // Lisbon coordinates
    Producer srFernandoLisboa = new Producer("SR_FERNANDO_LISBOA", 38.72225, -9.13934, "LIS");
    // Faro coordinates
    Producer srJoseFaro = new Producer("SR_JOSE_FARO", 37.01987, -7.93206, "FAO");
    // Guarda coordinates
    Producer srAntonioGuarda = new Producer("SR_ANTONIO_GUARDA", 40.53726, -7.26337, "GUA");

    // Braga coordinates
    Client dAliceBraga = new Client("D_ALICE_BRAGA", 41.54545, -8.42653, "BGZ");
    // Castelo Branco coordinates
    Client dManuelaCBranco = new Client("D_MANUELA_CBRANCO", 39.81909, -7.43889, "CBR");
    // Vila real coordinates
    Client dLuisaVReal = new Client("D_LUISA_VREAL", 41.30045, -7.74482, "VRL");

    // Aveiro coordinates
    Enterprise hubAveiro = new Enterprise("HUB_AVEIRO", 40.64427, -8.64554, "AVE");
    // Coimbra coordinates
    Enterprise hubCoimbra = new Enterprise("HUB_COIMBRA", 40.20331, -8.41025, "COI");
    // Leiria coordinates
    Enterprise hubLeiria = new Enterprise("HUB_LEIRIA", 39.74383, -8.80777, "LEI");
    // Viseu coordinates
    Enterprise hubViseu = new Enterprise("HUB_VISEU", 40.65716, -7.90907, "VIS");

    this.distributionNetwork.addRelation(srManuelPorto, hubAveiro, 75);
    this.distributionNetwork.addRelation(srManuelPorto, dAliceBraga, 60);
    this.distributionNetwork.addRelation(srManuelPorto, dLuisaVReal, 100);
    this.distributionNetwork.addRelation(hubViseu, srAntonioGuarda, 75);
    this.distributionNetwork.addRelation(srAntonioGuarda, dManuelaCBranco, 100);
    this.distributionNetwork.addRelation(hubAveiro, hubCoimbra, 60);
    this.distributionNetwork.addRelation(hubCoimbra, srFernandoLisboa, 200);
    this.distributionNetwork.addRelation(hubCoimbra, hubLeiria, 80);
    this.distributionNetwork.addRelation(hubAveiro, hubLeiria, 120);
    this.distributionNetwork.addRelation(hubLeiria, srFernandoLisboa, 150);
    this.distributionNetwork.addRelation(hubAveiro, hubViseu, 85);
    this.distributionNetwork.addRelation(hubLeiria, dManuelaCBranco, 170);
    this.distributionNetwork.addRelation(srFernandoLisboa, srJoseFaro, 280);

    DefineHubsController defineHubsController = new DefineHubsController(this.distributionNetwork);
    defineHubsController.defineHubs(4);

    Map<Product, Integer> srManuelOrderedProducts = new HashMap<Product, Integer>();
    srManuelOrderedProducts.put(macaDeAlcobaca, 10);
    Map<Product, Integer> srFernandoOrderedProducts = new HashMap<Product, Integer>();
    srFernandoOrderedProducts.put(bananaDaMadeira, 10);
    Map<Product, Integer> srManuelAndFernandoOrderedProducts = new HashMap<Product, Integer>();
    srManuelAndFernandoOrderedProducts.put(macaDeAlcobaca, 10);
    srManuelAndFernandoOrderedProducts.put(bananaDaMadeira, 10);

    Map<Producer, Map<Product, Integer>> srManuelReceivedProducts = new HashMap<Producer, Map<Product, Integer>>();
    srManuelReceivedProducts.put(srManuelPorto, srManuelOrderedProducts);
    Map<Producer, Map<Product, Integer>> srFernandoReceivedProducts = new HashMap<Producer, Map<Product, Integer>>();
    srFernandoReceivedProducts.put(srFernandoLisboa, srFernandoOrderedProducts);
    Map<Producer, Map<Product, Integer>> srManuelAndFernandoReceivedProducts = new HashMap<Producer, Map<Product, Integer>>();
    srManuelAndFernandoReceivedProducts.put(srManuelPorto, srManuelOrderedProducts);
    srManuelAndFernandoReceivedProducts.put(srFernandoLisboa, srFernandoOrderedProducts);

    dAliceBasket = new Basket(srManuelOrderedProducts, srManuelReceivedProducts, hubLeiria, dAliceBraga);
    dManuelaBasket = new Basket(srFernandoOrderedProducts, srFernandoReceivedProducts, hubViseu, dManuelaCBranco);
    dLuisaBasket = new Basket(srManuelAndFernandoOrderedProducts, srManuelAndFernandoReceivedProducts, hubCoimbra,
        dLuisaVReal);
  }

  @Test
  public void testWithDAliceBasket() {
    // NESTE TESTE, COM A OTIMIZACAO DOS HUBS, O RESULTADO SERIA:
    // Expedition path for day 1:
    // >> Stop 1: Producer SR_MANUEL_PORTO
    // >> Stop 2: Hub HUB_AVEIRO
    // >> Stop 3: Hub HUB_LEIRIA
    // >> Stop 4: Producer SR_FERNANDO_LISBOA
    // >> Stop 5: Hub HUB_COIMBRA
    // >> Stop 6: Hub HUB_AVEIRO
    // >> Stop 7: Hub HUB_VISEU

    // EM VEZ DE

    // Expedition path for day 1:
    // >> Stop 1: Producer SR_MANUEL_PORTO
    // >> Stop 2: Hub HUB_AVEIRO
    // >> Stop 3: Hub HUB_LEIRIA
    // >> Stop 4: Producer SR_FERNANDO_LISBOA
    // >> Stop 5: Hub HUB_LEIRIA
    // >> Stop 6: Hub HUB_COIMBRA
    // >> Stop 7: Hub HUB_AVEIRO
    // >> Stop 8: Hub HUB_VISEU

    this.expeditionList = new ExpeditionList(1);
    this.expeditionList.addBasket(dLuisaBasket);
    this.expeditionList.addBasket(dManuelaBasket);
    this.expeditionList.addBasket(dAliceBasket);

    ExpeditionPathController expeditionPathController = new ExpeditionPathController(this.distributionNetwork,
        this.expeditionList);
    ExpeditionPath path = expeditionPathController.findExpeditionPath();

    path.printPath();
  }
}