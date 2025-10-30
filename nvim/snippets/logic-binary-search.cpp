int low = 0, high = N;
while(low+1<high) {
    int mid = (low+high)/2;

    // 

    if (check(mid)){
        low = mid;
    } else {
        high = mid;
    }
}
