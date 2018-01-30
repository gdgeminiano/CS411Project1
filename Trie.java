import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

public class Trie
{

    String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    char[] alpha = alphabet.toCharArray();
    int[] Switch = new int[alphabet.length()];
    char[] symbol;
    int[] next;

    int ptr = 0;
    int nextOpen = 0;

    public Trie(int size)
    {
        symbol = new char[size];
        next = new int[symbol.length];
        Arrays.fill(Switch, -1);
        Arrays.fill(next, -1);
    }

    public Trie()
    {
        symbol = new char[5000];
        next = new int[symbol.length];
        Arrays.fill(Switch, -1);
        Arrays.fill(next, -1);
    }



    public boolean insert(String str)
    {
        String toAdd = str + "@";
        int nextSymbol = 0;
        int index = alphabet.indexOf(toAdd.charAt(nextSymbol));

        ptr = Switch[index];


        if (ptr == -1)
        {
            Switch[index] = nextOpen;
            create(toAdd.substring(1));
        }
        else
        {
            nextSymbol++;
            boolean exit = false;

            while(!exit)
            {
                if(symbol[ptr] == toAdd.charAt(nextSymbol))
                {
                    if(toAdd.charAt(nextSymbol) != '@')
                    {
                        ptr++;
                        nextSymbol++;
                    }
                    else{
                        exit = true;
                        return false;
                    }
                }else if(next[ptr] != -1)
                {
                    ptr = next[ptr];
                }
                else
                {
                    next[ptr] = nextOpen;
                    System.out.println(toAdd.substring(nextSymbol));
                    create(toAdd.substring(nextSymbol));
                    exit = true;
                }
            }

        }

        return true;

    }

    public void create(String str)
    {
        ptr = nextOpen;

        for(int i = 0; i < str.length(); i++) {
            symbol[nextOpen] = str.charAt(i);
            nextOpen++;
        }
    }

    public void print(String output) {
        try (PrintWriter pw = new PrintWriter(
                new BufferedWriter(new FileWriter(output, true)))) {
            // PRINTING FORMATTED
            pw.println();
            int a1 = 0;
            int s1 = 0;
            while (a1 < 40) {
                pw.print("        ");
                for (int a = 0; a < 20; a++)
                    pw.printf("%4c ", alpha[a1++]);
                pw.println();
                pw.print("switch: ");
                for (int a = 0; a < 20; a++)
                    pw.printf("%4d ", Switch[s1++]);
                pw.println("\n");
            }
            pw.print("        ");
            for (int a = 40; a < alpha.length; a++)
                pw.printf("%4c ", alpha[a1++]);
            pw.println();
            pw.print("switch: ");
            for (int a = 40; a < alpha.length; a++)
                pw.printf("%4d ", Switch[s1++]);
            pw.println("\n");
            int count = 0;
            int s2 = 0;
            int n2 = 0;
            while (count < symbol.length) {
                pw.print("        ");
                for (int n = 0; n < 20; n++)
                    pw.printf("%4d ", count++);
                pw.println();
                pw.print("symbol: ");
                for (int n = 0; n < 20; n++)
                    pw.printf("%4c ", symbol[s2++]);
                pw.println();
                pw.print("next:   ");
                for (int n = 0; n < 20; n++) {
                    if (next[n2] != -1) {
                        pw.printf("%4d ", next[n2++]);
                    } else {
                        pw.printf("%4c ", ' ');
                        n2++;
                    }
                }
                pw.println("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
