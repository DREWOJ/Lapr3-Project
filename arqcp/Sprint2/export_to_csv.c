#include <stdio.h>
#include <string.h>
#include <time.h>

#include "sensor.h"
#include "shared.h"
#include "limits.h"
#include "sensor_summary.h"

void format_time(char *output);

void write_csv(char *buffer, char const *name) {
    FILE *file_ptr;
    char file_name[50];
    strcpy(file_name, "exported_");
    strcat(file_name, name);

    char date[25];
    format_time(date);
    strcat(file_name, date);
    // exported_result_2023-01-01_10-00-01.csv

    strcat(file_name, ".csv");

    file_ptr = fopen(file_name, "w");
    fprintf(file_ptr, "%s", buffer);
    fclose(file_ptr);
}

void export_result(Sensor **data, unsigned int const *n_sensors) {
    char buffer[16384]; // be careful with buffer overflow
    strcpy(buffer, "Nome,Tipo,ID,Leitura,Erro\n");

    char temp[256]; // here too
    for (int j = 0; j < n_sensors[0]; j++) {
        for (int k = 0; k < data[0][j].readings_size; k++) {
            sprintf(temp, "%s,%s,%hu,%d%s,%hhu\n", data[0][j].name, SENSOR_TYPE_DESIGNATIONS[data[0][j].sensor_type], data[0][j].id, data[0][j].readings[k], data[0][j].units, data[0][j].errors[k]);
            strcat(buffer, temp);
        }
    }
 
    for (int i = 1; i < NUM_OF_SENSOR_TYPES; i++) {
        for (int j = 0; j < n_sensors[i]; j++) {
            for (int k = 0; k < data[i][j].readings_size; k++) {
                sprintf(temp, "%s,%s,%hu,%u%s,%hhu\n", data[i][j].name, SENSOR_TYPE_DESIGNATIONS[data[i][j].sensor_type], data[i][j].id, data[i][j].readings[k], data[i][j].units, data[i][j].errors[k]);
                strcat(buffer, temp);
            }
        }
    }
    
    write_csv(buffer, "result");
}

void export_summary(Sensor **data, unsigned int const *n_sensors) {
    char buffer[16384]; // be careful with buffer overflow
    strcpy(buffer, "Tipo,Mínimo,Máximo,Média\n");

    int result[NUM_OF_SENSOR_TYPES][SUMMARY_COLUMNS];
    get_summary_matrix(data, n_sensors, result);

    char temp[256];
    for (int i = 0; i < NUM_OF_SENSOR_TYPES; i++) {
	sprintf(temp, "%s,%d,%d,%d\n", SENSOR_TYPE_DESIGNATIONS[i], result[i][0], result[i][1], result[i][2]);
	strcat(buffer, temp);
    }

    write_csv(buffer, "summary");
}

void format_time(char *output){
    time_t rawtime;
    struct tm *timeinfo;
    
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    
    sprintf(output, "_%d-%02d-%02d_%02d-%02d-%02d", timeinfo->tm_year + 1900,
            timeinfo->tm_mon + 1, timeinfo->tm_mday,
            timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
}

