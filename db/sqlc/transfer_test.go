package db

import (
	"context"
	"testing"
	"time"

	"github.com/stretchr/testify/require"
)

func createRandomTransfer(t *testing.T, fromAccountID, toAccountID int64) Transfer {
	arg := CreateTransferParams{
		FromAccountID: fromAccountID,
		ToAccountID:   toAccountID,
		Amount:        int64(10), // example amount
	}

	transfer, err := testQueries.CreateTransfer(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, transfer)

	require.Equal(t, arg.FromAccountID, transfer.FromAccountID)
	require.Equal(t, arg.ToAccountID, transfer.ToAccountID)
	require.Equal(t, arg.Amount, transfer.Amount)

	require.NotZero(t, transfer.ID)
	require.NotZero(t, transfer.CreatedAt)

	return transfer
}

func TestCreateTransfer(t *testing.T) {
	// Create Account First and Second
	accountFirst := createRandomAccount(t)
	accountSecond := createRandomAccount(t)
	fromAccountID := accountFirst.ID // example account ID
	toAccountID := accountSecond.ID  // example account ID

	createRandomTransfer(t, fromAccountID, toAccountID)
}

func TestGetTransfer(t *testing.T) {
	accountFirst := createRandomAccount(t)
	accountSecond := createRandomAccount(t)
	fromAccountID := accountFirst.ID // example account ID
	toAccountID := accountSecond.ID  // example account ID

	transfer1 := createRandomTransfer(t, fromAccountID, toAccountID)
	transfer2, err := testQueries.GetTransfer(context.Background(), transfer1.ID)
	require.NoError(t, err)
	require.NotEmpty(t, transfer2)

	require.Equal(t, transfer1.ID, transfer2.ID)
	require.Equal(t, transfer1.FromAccountID, transfer2.FromAccountID)
	require.Equal(t, transfer1.ToAccountID, transfer2.ToAccountID)
	require.Equal(t, transfer1.Amount, transfer2.Amount)
	require.WithinDuration(t, transfer1.CreatedAt, transfer2.CreatedAt, time.Second)
}

func TestListTransfers(t *testing.T) {
	accountFirst := createRandomAccount(t)
	accountSecond := createRandomAccount(t)
	fromAccountID := accountFirst.ID // example account ID
	toAccountID := accountSecond.ID  // example account ID

	for i := 0; i < 10; i++ {
		createRandomTransfer(t, fromAccountID, toAccountID)
	}

	arg := ListTransfersParams{
		FromAccountID: fromAccountID,
		ToAccountID:   toAccountID,
		Limit:         5,
		Offset:        0,
	}

	transfers, err := testQueries.ListTransfers(context.Background(), arg)
	require.NoError(t, err)
	require.Len(t, transfers, 5)

	for _, transfer := range transfers {
		require.NotEmpty(t, transfer)
	}
}
