package isep.model;

public class Producer extends Entity {

  public Producer(String id, double latitude, double longitude, String localizationId) {
    super(id, latitude, longitude, localizationId);
  }

  public DailyData getStockUntilDate(Integer day) {
    return this.dailyData.getDailyDataUntilDate(day);
  }
}
