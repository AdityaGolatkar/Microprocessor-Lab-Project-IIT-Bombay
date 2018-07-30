# include <iostream>
# include <string>
using namespace std;

int main()
{
	string s;
	int i =0;
	while(cin>>s)
        {
		if(i%2==0)
		{
			cout<<s<<" => "<<s<<","<<endl;
		}
		i++;
	}
}
