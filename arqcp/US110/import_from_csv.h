#ifndef IMPORT_FROM_CSV_H
#define IMPORT_FROM_CSV_H

typedef struct {
    char name[50];
    int number_sensors;
} sensor_n;

void import_from_csv(char *filename, sensor_n *sensors);

#endif