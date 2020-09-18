public class Uniform {

    private final int a = -3;
    private final int b = 7;
    private double[] x;

    public void uniform_distribution(double[] R) {
        System.out.println();
        System.out.println("uniform_distribution");

        x = new double[R.length];

        for (int i = 0; i < R.length; i++) {
            x[i] = a + (b - a) * R[i];
        }

        for (int i = 0; i < R.length; i++) {
            System.out.println(x[i]);
        }
    }
}