import java.math.BigInteger;

public class DSA {
    public static void main(String[] args) {

        BigInteger P = new BigInteger("6703903964971298549787012499102923063739682910296196688861780721860882015036773488400937149083451713845015929093243075248275515306546773467380133546744897");
        BigInteger q = new BigInteger("6561744538617343330441949809163252173");

        BigInteger h = BigInteger.valueOf(2);
        BigInteger G = h.modPow(P.subtract(BigInteger.ONE).divide(q), P);

        BigInteger x = BigInteger.valueOf(7);

        BigInteger Y = (G.pow(x.intValue())).mod(P);

        RIPEMD128 ripemd128 = new RIPEMD128();
        BigInteger m = ripemd128.hash("abc");
        BigInteger k = BigInteger.valueOf(3);
        BigInteger r = ((G.pow(k.intValue())).mod(P)).mod(q);
        BigInteger s = (k.modInverse(q).multiply((x.multiply(r)).add(m))).mod(q);

        System.out.println("r = " + r);
        System.out.println("s = " + s);

        BigInteger w = s.modInverse(q);

        BigInteger u1 = (m.multiply(w)).mod(q);
        BigInteger u2 = (r.multiply(w)).mod(q);

        BigInteger V = (G.modPow(u1,P))
                .multiply(Y.modPow(u2, P))
                .mod(P)
                .mod(q);

        System.out.println("v = " + V);
    }
}
