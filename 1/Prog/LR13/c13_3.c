/*
Задача:
	На вход программы поступает два целых числа, на экран выводится их наибольший общий делитель (НОД).
Пример:
	x = 87.567, Вывод на экран: 1010111
*/

#include <stdio.h>

int main()
{
	long int a=0, b=0, d=0, i=0, j=0;

	printf("Введите два целых числа: ");
	scanf("%ld %ld", &a, &b);

	if (a < b)
	{
		j = a;
		a = b;
		b = j;
	}
	d = a;
	i = b;
	while (d - i != 0)
	{
		j = d - i;
		if (j > i)
			d = j;
		else
		{
			d = i;
			i = j;
		}
	}
	printf("\tНаибольший общий делитель чисел %ld и %ld: %ld\n", a, b, d);
	return 0;
}