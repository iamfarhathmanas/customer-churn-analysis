import pandas as pd

df = pd.read_csv('../data/customer_churn.csv')

def churn_rate(series):
    return (series.eq('Yes').mean() * 100).round(2)

print(f"Overall churn rate: {churn_rate(df['churned'])}%")
print('\nChurn by contract type:')
print(df.groupby('contract_type')['churned'].apply(churn_rate).sort_values(ascending=False))

df['tenure_group'] = pd.cut(
    df['tenure_months'],
    bins=[0, 12, 24, 48, 100],
    labels=['0-12', '13-24', '25-48', '49+']
)
print('\nChurn by tenure group:')
print(df.groupby('tenure_group', observed=True)['churned'].apply(churn_rate))

print('\nChurn by support-ticket group:')
df['support_group'] = df['support_tickets'].apply(lambda x: '4+ tickets' if x >= 4 else '0-3 tickets')
print(df.groupby('support_group')['churned'].apply(churn_rate).sort_values(ascending=False))
