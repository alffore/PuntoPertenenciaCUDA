CC= nvcc -c

CLINKER= nvcc -o

DIR_SRC=./src/
DIR_OBJ=./obj/
DIR_BIN=./bin/

FLAGS= -lproj

all: clean main algoritmo lectores coordenadas salidas
	$(CLINKER) $(DIR_BIN)puntopertencia_cuda.exe $(DIR_OBJ)*.o $(FLAGS)

linkeo:
	$(CLINKER) $(DIR_BIN)puntopertencia_cuda.exe $(DIR_OBJ)*.o $(FLAGS)

main:
	$(CC) $(DIR_SRC)main/*.cu 
	@mv *.o $(DIR_OBJ)


lectores:
	$(CC) $(DIR_SRC)lectores/*.cu 
	@mv *.o $(DIR_OBJ)


algoritmo:
	$(CC) $(DIR_SRC)algoritmo/*.cu 
	@mv *.o $(DIR_OBJ)


salidas:
	$(CC) $(DIR_SRC)salidas/*.cu 
	@mv *.o $(DIR_OBJ)


coordenadas:
	$(CC) $(DIR_SRC)coordenadas/*.cu 
	@mv *.o $(DIR_OBJ)

test:
	$(CC) $(DIR_SRC)test/*.cu 
	@mv *.o $(DIR_OBJ)

clean:
	@rm -rfv $(DIR_OBJ)*.o
	@rm -rfv $(DIR_BIN)*.exe