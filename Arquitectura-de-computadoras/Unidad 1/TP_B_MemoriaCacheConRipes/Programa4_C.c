int getPromedio(int,int,int,int);
int getSuma(int,int,int);
int getResta(int,int);

void main() {
    
    int num1 = 12,
        num2 = 3,
        num3 = 9,
        num4 = 6;
        
    int prom = getPromedio(num1,num2,num3,num4);
    int suma = getSuma(num1,num3,num4);
    int resta = getResta(num2,num3);
}

int getPromedio(int num1, int num2, int num3, int num4) {
    int suma = num1 + num2 + num3 + num4;
    int promedio = (int) suma / 4;
    return promedio;
}

int getSuma(int num1, int num2, int num3) {
    int suma = num1 + num2 + num3;    
    return suma;
}

int getResta(int num1, int num2) {
    int resta = num1 - num2;
    return resta;
}