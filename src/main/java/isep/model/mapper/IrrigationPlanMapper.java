package isep.model.mapper;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;
import javax.naming.NameNotFoundException;
import isep.model.AgriculturalParcel;
import isep.model.IrrigationPlan;
import isep.model.ParcelIrrigationWrapper;
import isep.model.RegularityFactory;
import isep.model.Regularity;
import isep.model.store.AgriculturalParcelStore;
import isep.shared.Constants;
import isep.shared.Hour;
import isep.shared.exceptions.InvalidFileFormatException;
import isep.shared.exceptions.InvalidHourFormatException;

/**
 * The IrrigationPlanMapper class takes a list as an input and outputs an IrrigationPlan object.
 *
 * @author Ricardo Moreira <1211285@isep.ipp.pt>
 */
public class IrrigationPlanMapper {
  private IrrigationPlanMapper() {}

  public static IrrigationPlan toPlan(List<String> data, Calendar creationDate,
      AgriculturalParcelStore parcelStore)
      throws InvalidHourFormatException, InvalidFileFormatException, NameNotFoundException {
    List<Hour> hours = new ArrayList<>();
    List<ParcelIrrigationWrapper> parcels = new LinkedList<>();

    // header contains hours
    String[] header = data.get(0).split(",");
    for (int i = 0; i < header.length; i++) {
      hours.add(new Hour(header[i]));
    }

    // the following lines contain the irrigation plan for a specific parcel
    for (int i = 1; i < data.size(); i++) {
      String[] line = data.get(i).split(",");
      if (line.length != 3)
        throw new InvalidFileFormatException(String.format("File is not ok, line %d", i + 1));

      String parcelDesignation = line[0];
      String durationStr = line[1];
      String regularity = line[2];

      AgriculturalParcel foundParcel = parcelStore.findParcelByDesignation(parcelDesignation);
      if (foundParcel == null)
        throw new NameNotFoundException(
            String.format("Parcel %s not found in store", parcelDesignation));

      int duration = Integer.parseInt(durationStr);

      Regularity method = RegularityFactory.getRegularity(regularity);

      ParcelIrrigationWrapper wrapper = new ParcelIrrigationWrapper(foundParcel, duration, method);
      parcels.add(wrapper);
    }

    creationDate.set(Calendar.HOUR_OF_DAY, 0);
    creationDate.set(Calendar.MINUTE, 0);
    creationDate.set(Calendar.SECOND, 0);
    creationDate.set(Calendar.MILLISECOND, 0);

    IrrigationPlan irrigationPlan = new IrrigationPlan(hours, parcels, creationDate,
        Constants.DEFAULT_IRRIGATION_PLAN_DURATION);

    return irrigationPlan;
  }
}
