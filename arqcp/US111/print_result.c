#include <stdio.h>
#include <string.h>

#include "sensor.h"
#include "shared.h"
#include "limits.h"

void print_result(Sensor *arr, unsigned int size) {
    if (size == 0) return;
    printf("-- Registos %s: --\n", SENSOR_TYPE_DESIGNATIONS[arr[0].sensor_type]);
    for (int j = 0; j < size; j++) {
        printf("\nSensor id %d:\n", arr[j].id);
        for (int i = 0; i < arr[j].readings_size; i++) {
            printf("Leitura: %u%s %s\n", arr[j].readings[i], arr[j].units, arr[j].errors[i] == 1 ? "(Erro)" : "");
        }   
    }
}

void print_signed_result(Sensor *arr, unsigned int size) {
    if (size == 0) return;

    printf("-- Registos %s: --\n", SENSOR_TYPE_DESIGNATIONS[arr[0].sensor_type]);
    for (int j = 0; j < size; j++) {
        printf("\nSensor id %d:\n", arr[j].id);
        for (int i = 0; i < arr[j].readings_size; i++) {
            printf("Leitura: %d%s %s\n", (char)arr[j].readings[i], arr[j].units, arr[j].errors[i] == 1 ? "(Erro)" : "");
        }
    }
}

void print_small(Sensor **data, unsigned int const *n_sensors) {
    for (int i = 0; i < NUM_OF_SENSOR_TYPES; i++) {
        printf("Sensores do tipo %s:\n", data[i][0].name);

        for (int j = 0; j < n_sensors[i]; j++) {
            Sensor s = data[i][j];
            int errors = get_total_errors(s);
            printf(" - Sensor %d (id %hu): %lu leituras [%d]\n", j+1, s.id, s.readings_size, errors);
        }
    }
}

