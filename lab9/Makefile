CC=gcc
CFLAGS=-I. --shared -fPIC -o libsymtab.so

lltest: clean
	$(CC) symtab_ll.c $(CFLAGS)
	@echo "Running test for linked list implementation..."
	@python3 test.py ||:
httest: clean
	$(CC) symtab_ht.c $(CFLAGS)
	@echo "Running test for hash table implementation..."
	@python3 test.py ||:
bttest: clean
	$(CC) symtab_bt.c $(CFLAGS)
	@echo "Running test for binary tree implementation..."
	@python3 test.py ||:
clean:
	@rm -f *.o *.out *.so
.PHONY: lltest httest bttest
