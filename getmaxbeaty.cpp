#include <vector>
#include <algorithm>
using namespace std;

long getMaxBeuty(vector<int> arr) {
    int n = arr.size();

    sort(arr.begin(), arr.end());

    long ans = 0;

    if (n % 2 == 1) {
        int k = (n + 1) / 2;
        for (int i = n - 1; i >= n - k; i--) {
            ans += arr[i];
        }
    } 
    else 
    {
        int k = n / 2;
        for (int i = 0; i < k; i++) {
            ans -= arr[i];
        }
    }

    return ans;
}

